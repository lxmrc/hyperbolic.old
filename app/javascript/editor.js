import CodeMirror from "./src/codemirror"

window.onload = function () { 
  let editor = document.getElementById("editor");
  let tests = document.getElementById("tests");
  let terminal = document.getElementById("terminal");

  let theme = "default";

  if (editor !== null) {
    window.editor = CodeMirror.fromTextArea(editor, {
      lineNumbers: true,
      mode: "ruby",
      theme: theme,
      keyMap: "vim"
    });
  }

  if (tests !== null) {
    window.tests = CodeMirror.fromTextArea(tests, {
      lineNumbers: true,
      mode: "ruby",
      theme: theme,
      readOnly: true
    });
  }

  if (terminal !== null) {
  window.terminal = CodeMirror.fromTextArea(terminal, {
    mode: "shell",
    theme: theme,
    readOnly: true
  });
  }
} 

