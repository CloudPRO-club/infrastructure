const core = require('@actions/core');

try {
    const sourceString = core.getInput('source-string');
    const oldSubstring = core.getInput('old-substring');
    const newSubstring = core.getInput('new-substring');

    const resultString = sourceString.split(oldSubstring).join(newSubstring);

    core.setOutput("result-string", resultString);
} catch (error) {
    core.setFailed(error.message);
}