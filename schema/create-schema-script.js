/**
 * CLI tool to generate a 'create database' script, using as source all objects
 * DDL files here; the result is usually stored as `schema.sql`.
 *
 * @example `node ./schema/create-schema-script > schema.sql`
 * @example Provide different database name as first parameter like in
 * `node ./schema/create-schema-script loconomicstest > schema.sql`
 */
'use strict';
const util = require('util');
const fs = require('fs');
const path = require('path');

const readdir = util.promisify(fs.readdir);
const readFile = util.promisify(fs.readFile);

const schemaDir = __dirname + '/dbo';
const defaultDataBaseName = 'loconomics';

/**
 * @typedef {Object} ScriptObjectContent
 * @property {string} name Object name
 * @property {string} content SQL DDL script content
 */

/**
 *
 * @param {Array<ScriptObjectContent>} contents
 */
function concatenateScripts(contents, createLabel) {
    return contents.reduce((result, { name, content }) => {
        return result + `
PRINT N'${createLabel(name)}';
GO
${content}
GO
        `;
    }, '');
}

/**
 * Table scripts are special, since we need to separate the CREATE statement
 * from the rest of batch tasks in the file, so we can prevent dependencies
 * errors, specially because of foreign keys. This way, with the source having
 * FKs defined as contraints in a 'ALTER' statement, will not fail if run
 * after all tables were declared.
 * @param {Array<ScriptObjectContent>} contents
 * @param {Function<string,string>} createLabel
 */
function concatenateTableScripts(contents, createLabel) {
    // Separate CREATE statements (first in the file), from the rest
    // creating two sets of parts on each
    const createDdls = [];
    const restDdls = [];
    contents.forEach(function({ content }) {
        const batchStart = content.indexOf('GO');
        if (batchStart > -1) {
            createDdls.push(content.substring(0, batchStart));
            restDdls.push(content.substr(batchStart + 2));
        }
        else {
            createDdls.push(content);
            restDdls.push('');
        }
    });

    // First, all CREATEs
    let result = contents.map(({ name }, index) => `
PRINT N'${createLabel(name)}';
GO
${createDdls[index]}
GO
    `).join('');

    // Last, rest of DDLs on each script
    result += contents.map(({ name }, index) => `
PRINT N'Altering [dbo].[${name}]...';
GO
${restDdls[index]}
GO
    `).join('');

    return result;
}

function createObjectLabel(name) {
    return `Creating [dbo].[${name}]...`;
}

function createDatabaseLabel(name) {
    return `Creating database [${name}]...`;
}

function caseInsensitiveComparer(a, b) {
    return a.toLowerCase().localeCompare(b.toLowerCase());
}

/**
 * Remove the BOM mark at the beggining of some UTF-8 files
 */
function trimUtfBom(content) {
    // It's EFBBBF but buffer-to-string
	// converts that as FEFF (UTF-16 BOM)
	if (content.charCodeAt(0) === 0xFEFF) {
        return content.slice(1);
    }
    else return content;
}

function replaceScriptVars(content, vars) {
    return content.replace(/\$\(DatabaseName\)/g, vars.databaseName);
}

async function concatenateDirContent(dir, createLabelFn, vars, concatFn) {
    const files = await readdir(dir);
    // We keep an alphabetical order for all the content in order
    // to get predictable results, so we sort file names and map results keeping
    // it and procesing only when all ready (rather than as soon as one available
    // that would be unreliable, and let for forgottent content if some fails
    // later).
    files.sort(caseInsensitiveComparer);
    const sqlFiles = files.filter((name) => /\.sql$/i.test(name));
    const contents = await Promise.all(sqlFiles.map(async (file) => {
        const content = await readFile(path.join(dir, file), 'utf8');
        return {
            name: path.basename(file, '.sql'),
            content: replaceScriptVars(trimUtfBom(content), vars),
        };
    }));
    if (concatFn) {
        return concatFn(contents, createLabelFn);
    }
    else {
        return concatenateScripts(contents, createLabelFn);
    }
}

async function run(settings) {
    const contents = await Promise.all([
        concatenateDirContent(schemaDir, createDatabaseLabel.bind(null, settings.databaseName), settings),
        concatenateDirContent(schemaDir + '/Tables', createObjectLabel, settings, concatenateTableScripts),
        concatenateDirContent(schemaDir + '/Functions', createObjectLabel, settings),
        concatenateDirContent(schemaDir + '/Views', createObjectLabel, settings),
        concatenateDirContent(schemaDir + '/Stored Procedures', createObjectLabel, settings),
    ]);
    const result = contents.join('\n');
    console.log(result);
}

run({
    databaseName: process.argv[2] || defaultDataBaseName
});
