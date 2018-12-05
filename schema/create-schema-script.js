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

async function concatenateDirContent(dir, createLabelFn, vars) {
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
    return concatenateScripts(contents, createLabelFn);
}

async function run(settings) {
    const contents = await Promise.all([
        concatenateDirContent(schemaDir, createDatabaseLabel, settings),
        concatenateDirContent(schemaDir + '/Tables', createObjectLabel, settings),
        concatenateDirContent(schemaDir + '/Views', createObjectLabel, settings),
        concatenateDirContent(schemaDir + '/Functions', createObjectLabel, settings),
        concatenateDirContent(schemaDir + '/Stored Procedures', createObjectLabel, settings),
    ]);
    const result = contents.join('\n');
    console.log(result);
}

run({
    databaseName: process.argv[2] || defaultDataBaseName
});
