/**
 * CLI tool to generate a 'create database' script, using as source all objects
 * DDL files here; the result is usually stored as `schema.sql`.
 *
 * @example `node ./schema/create-schema-script > schema.sql`
 */
'use strict';
const util = require('util');
const fs = require('fs');
const path = require('path');

const readdir = util.promisify(fs.readdir);
const readFile = util.promisify(fs.readFile);

const schemaDir = __dirname + '/dbo';
const databaseName = 'loconomics';

/**
 * @typedef {Object} ScriptObjectContent
 * @property {string} name Object name
 * @property {string} content SQL DDL script content
 */

/**
 *
 * @param {Array<ScriptObjectContent>} contents
 */
function concatenateScripts(contents) {
    return contents.reduce((result, { name, content }) => {
        return result + `
PRINT N'Creating [dbo].[${name}]...';
GO
${content}
GO
        `;
    }, '');
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

function replaceScriptVars(content) {
    return content.replace(/\$\(DatabaseName\)/g, databaseName)
}

async function concatenateDirContent(dir) {
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
            content: replaceScriptVars(trimUtfBom(content)),
        };
    }));
    return concatenateScripts(contents);
}

async function run() {
    const contents = await Promise.all([
        concatenateDirContent(schemaDir),
        concatenateDirContent(schemaDir + '/Tables'),
        concatenateDirContent(schemaDir + '/Views'),
        concatenateDirContent(schemaDir + '/Functions'),
        concatenateDirContent(schemaDir + '/Stored Procedures'),
    ]);
    const result = contents.join('\n');
    console.log(result);
}

run();
