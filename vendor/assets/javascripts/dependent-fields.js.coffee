# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


toggle = ($parent, showOrHide, method, duration) ->
  fieldsSelector = 'input,textarea,select'
  fieldsAndBtnsSelector = fieldsSelector+',button'
  parentVisibleSelector = ':not(.js-dependent-fields-hidden)'
  if showOrHide
    $parent.removeClass 'js-dependent-fields-hidden'
    $parentVisible = $parent.find(parentVisibleSelector)
    if method != 'hide' # disable or default
      $fieldsAndBtns = $parentVisible.find(fieldsAndBtnsSelector)
      # only enable if it was enabled before hiding
      $fieldsAndBtns.filter("[data-dependent-fields-disabled='no']").prop('disabled', false)
      $fieldsAndBtns.removeAttr('data-dependent-fields-disabled')
      # use attr instead of prop, because prop does not work with twitter bootstrap button
      $parentVisible.find(".btn[data-dependent-fields-disabled='no']").removeAttr('disabled')
      # remove the disabled state
      $parentVisible.find('[data-dependent-fields-disabled]').removeAttr('data-dependent-fields-disabled')
    if method != 'disable' # hide or default
      $parentVisible.find(fieldsSelector).filter('[data-dependent-fields-required]').attr('required', 'required')
      $parent.show(duration)
  else
    $parent.addClass 'js-dependent-fields-hidden'
    if method != 'hide' # disable or default
      # store the disabled state
      $fieldsAndBtns = $parent.find(fieldsAndBtnsSelector + ', .btn').not('[data-dependent-fields-disabled]')
      $fieldsAndBtns.filter(':disabled').attr('data-dependent-fields-disabled', 'yes')
      $fieldsAndBtns.not(':disabled').attr('data-dependent-fields-disabled', 'no')
      # disable things
      $fieldsAndBtns.filter(fieldsAndBtnsSelector).prop('disabled', true)
      # use attr instead of prop, because prop does not work with twitter bootstrap button
      $fieldsAndBtns.not(fieldsAndBtnsSelector).attr('disabled', 'disabled')
    if method != 'disable' # hide or default
      $parent.find(fieldsSelector).filter('[required]').removeAttr('required').attr('data-dependent-fields-required', 'required')
      $parent.hide(duration)


showOrHideDependentFieldsSelect = (duration = 'fast') ->
  $select = $(this)

  showOrHideFields = ->
    $this = $(this)
    # use attr here instead of data because we do not want jquery to cast the string into js types
    showOrHide = _.contains($this.attr('data-option-value').split('|'), $select.val())
    toggle($this, showOrHide, $this.data('method'), duration)

  $(".js-dependent-fields[data-select-id=#{$select.attr('id')}]").each showOrHideFields


showOrHideDependentFieldsCheckbox = (duration = 'fast') ->
  $checkbox = $(this)

  showOrHideFields = ->
    $this = $(this)
    showOrHide = $this.data('checkbox-value') == $checkbox.is(':checked')
    toggle($this, showOrHide, $this.data('method'), duration)

  $(".js-dependent-fields[data-checkbox-id=#{$checkbox.attr('id')}]").each showOrHideFields


showOrHideDependentFieldsRadio = (duration = 'fast') ->
  $radio = $(this)

  showOrHideFields = ->
    $this = $(this)
    # use checked radio input of this radio input group
    $checkedRadio = $("input:checked[name=#{$radio.attr('name').replace(/\[/g, '\\[').replace(/]/g, '\\]')}]")
    # use attr here instead of data because we do not want jquery to cast the string into js types
    showOrHide = _.contains($this.attr('data-radio-value').split('|'), $checkedRadio.val())
    toggle($this, showOrHide, $this.data('method'), duration)

  $(".js-dependent-fields[data-radio-name=#{$radio.attr('name').replace(/\[/g, '\\[').replace(/]/g, '\\]')}]").each showOrHideFields


bind = ->
  $selects = $('select')
  $selects.each _.partial(showOrHideDependentFieldsSelect, 0)
  $selects.change showOrHideDependentFieldsSelect

  $inputs = $('input[type=checkbox]')
  $inputs.each _.partial(showOrHideDependentFieldsCheckbox, 0)
  $inputs.change showOrHideDependentFieldsCheckbox

  $radios = $('input[type=radio]')
  $radios.each _.partial(showOrHideDependentFieldsRadio, 0)
  $radios.change showOrHideDependentFieldsRadio


@DependentFields = {
  bind
}
