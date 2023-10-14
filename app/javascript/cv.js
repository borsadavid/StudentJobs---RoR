function countAndDisable() {
  var ongoingCheckboxes = document.querySelectorAll('#ongoing_checkbox');
  var count = ongoingCheckboxes.length;

  for (var i = 0; i < ongoingCheckboxes.length; i++) {
    var triggerCheckbox = ongoingCheckboxes[i];

    triggerCheckbox.addEventListener('click', function() {
      var finishedAtField = this.parentNode.querySelector('.finished_at_field');
      finishedAtField.disabled = this.checked;
    });
  }

  return count;
}
