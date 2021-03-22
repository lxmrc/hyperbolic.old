// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require("jquery")

Rails.start()
ActiveStorage.start()

import CodeMirror from "../src/codemirror"

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

import '../css/main.scss'
