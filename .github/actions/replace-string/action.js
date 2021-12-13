const core = require('@actions/core');

try {
    const sourceString = core.getInput('source-string');
    let oldSubstring = core.getInput('old-substring');
    const newSubstring = core.getInput('new-substring');

    if (!oldSubstring) {
        oldSubstring = " ";
    }

    const resultString = sourceString.split(oldSubstring).join(newSubstring);

    core.setOutput("result-string", resultString);
} catch (error) {
    core.setFailed(error.message);
}