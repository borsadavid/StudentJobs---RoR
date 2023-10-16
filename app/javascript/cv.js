function disableFinishDate(checkbox) {
  const form = checkbox.closest('form');
  const finishDateField = form.querySelector('[name="experience[finished_at]"]');
  finishDateField.disabled = checkbox.checked;
}

function handleFormSubmission(form) {
  $(form).on('ajax:complete', function(event, xhr, status, error) {
    var response = xhr.responseJSON;
    var messageContainer = $('<div>').addClass('message-container');

    if (xhr.status === 200) {
      var message = response.message;
      messageContainer.text(message);
      messageContainer.addClass('success-message');
    } else {
      var errorMessage = response.message || 'Something went wrong!';
      messageContainer.text(errorMessage);
      messageContainer.addClass('error-message');
    }
    $('.message-container').remove();

    $(form).after(messageContainer);
  });
}

function hideFormClass(button) {
  var formClass = button.closest('.form-class');
  formClass.style.display = 'none';

  var messageContainer = document.createElement('div');
  messageContainer.classList.add('message-container');
  messageContainer.classList.add('success-message');
  messageContainer.textContent = 'Deleted successfully';

  formClass.parentNode.insertBefore(messageContainer, formClass);
}



