# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


toggle = ($parent, showOrHide, method, duration) ->
  fieldsSelector = 'input,textarea,select'
  fieldsAndBtnsSelector = 'input,textarea,select,button,.btn'
  if showOrHide
    $parentVisible = $parent.find(':not(.js-dependent-fields:hidden)')
    if method != 'hide' # disable or default
      # use attr instead of prop, because prop does not work with twitter bootstrap button
      $parentVisible.find(fieldsAndBtnsSelector).removeAttr('disabled')
      $parentVisible.find('.select2').select2('enable') if $.fn.select2
    if method != 'disable' # hide or default
      $parentVisible.find(fieldsSelector).filter('[data-dependent-fields-required]').attr('required', 'required')
      $parent.show(duration)
  else
    if method != 'hide' # disable or default
      # use attr instead of prop, because prop does not work with twitter bootstrap button
      $parent.find(fieldsAndBtnsSelector).attr('disabled', 'disabled')
      $parent.find('.select2').select2('disable') if $.fn.select2
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
  $selects.not('[data-important]').each _.partial(showOrHideDependentFieldsSelect, 0)
  $selects.filter('[data-important]').each _.partial(showOrHideDependentFieldsSelect, 0)

  $selects.change showOrHideDependentFieldsSelect

  $inputs = $('input[type=checkbox]')
  $inputs.not('[data-important]').each _.partial(showOrHideDependentFieldsCheckbox, 0)
  $inputs.filter('[data-important]').each _.partial(showOrHideDependentFieldsCheckbox, 0)

  $inputs.change showOrHideDependentFieldsCheckbox

  $radios = $('input[type=radio]')
  $radios.not('[data-important]').each _.partial(showOrHideDependentFieldsRadio, 0)
  $radios.filter('[data-important]').each _.partial(showOrHideDependentFieldsRadio, 0)

  $radios.change showOrHideDependentFieldsRadio


@DependentFields = {
  bind
}
