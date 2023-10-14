function handleOngoingCheckbox(checkboxNumber) {
  toggleFinishedAtField();

  $(`#ongoing_checkbox_${checkboxNumber}`).change(function() {
    toggleFinishedAtField();
  });

  function toggleFinishedAtField() {
    if ($(`#ongoing_checkbox_${checkboxNumber}`).is(':checked')) {
      $(`#finished_at_field_${checkboxNumber}`).attr('disabled', 'disabled');
    } else {
      $(`#finished_at_field_${checkboxNumber}`).removeAttr('disabled');
    }
  }
}