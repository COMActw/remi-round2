// app/assets/javascripts/application.js

$(document).ready(function() {
  $('#register-btn').click(function() {
    // Fetch the registration form HTML using AJAX
    $.ajax({
      url: '/register',
      method: 'GET',
      dataType: 'script',
      success: function() {
        // Display the registration form as a pop-up
        $('#register-modal').modal('show');
      },
      error: function() {
        // Handle AJAX error
      }
    });
  });
});