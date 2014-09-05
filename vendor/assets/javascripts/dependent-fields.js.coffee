# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


toggle = ($parent, showOrHide, method, duration) ->
  if showOrHide
    if method == 'disable'
      # use attr instead of prop, because prop does not work with twitter bootstrap button
      $parent.find('input,textarea,select,button,.btn').removeAttr('disabled')
      $parent.find('.select2').select2('enable') if $.fn.select2
    else
      $parent.show(duration)
  else
    if method == 'disable'
      # use attr instead of prop, because prop does not work with twitter bootstrap button
      $parent.find('input,textarea,select,button,.btn').attr('disabled', 'disabled')
      $parent.find('.select2').select2('disable') if $.fn.select2
    else
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
