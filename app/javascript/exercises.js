import Rails from "@rails/ujs";

function startContainer() {
  let token = document.getElementById("iteration_token").value
  let id = document.getElementById("iteration_exercise_id").value
  Rails.ajax({ url: "/exercises/" + id + "/iterations/" + token + "/start_container",
    type: "POST" })
}

function runTests() {
  let token = document.getElementById("iteration_token").value
  let id = document.getElementById("iteration_exercise_id").value
  let code = document.querySelector(".CodeMirror").CodeMirror.doc.getValue();
  Rails.ajax({url: "/exercises/" + id + "/iterations/" + token + "/run_tests", 
          type: "POST",
          data: { "code": code }
  })
}

function stopContainer() {
  let token = document.getElementById("iteration_token").value
  let id = document.getElementById("iteration_exercise_id").value
  Rails.ajax({ url: "/exercises/" + id + "/iterations/" + token + "/stop_container",
    type: "POST" })
}

$(document).ready(() => {
  $("#run_tests").click(runTests);

  startContainer();
})

window.addEventListener("unload", function () {
  let data = new FormData()
  let iteration_token = document.getElementById("iteration_token").value
  let id = document.getElementById("iteration_exercise_id").value
  navigator.sendBeacon("/exercises/" + id + "/iterations/" + iteration_token + "/stop_container", data)
  return null;
});
