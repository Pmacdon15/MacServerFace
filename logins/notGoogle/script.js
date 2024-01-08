document.addEventListener("DOMContentLoaded", function () {
  let userNameInput = document.getElementById("userName");
  let passwordInput = document.getElementById("password");
  let userNameForm = document.getElementById("loginUserName");
  let passwordForm = document.getElementById("loginPassword");

  // Focus on the first input that is empty
  if (userNameInput) userNameInput.focus();
  
  // If the user presses enter while in the username field, submit the form
  if (userNameInput && userNameForm) {
    userNameInput.addEventListener("keydown", function (event) {
      if (event.key === "Enter") {
        event.preventDefault(); // Prevent the default form submission
        form.submit(); // Submit the form
      }
    });
  }

  // Focus on the first input that is empty
  if (passwordInput) passwordInput.focus();

  // If the user presses enter while in the password field, submit the form
  if (passwordInput && passwordForm) {
    passwordInput.addEventListener("keydown", function (event) {
      if (event.key === "Enter") {
        event.preventDefault(); // Prevent the default form submission
        passwordForm.submit(); // Submit the form
      }
    });
  }
});
