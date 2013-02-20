# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


toggle = ($parent, showOrHide, method, duration) ->
  if showOrHide
    if method == 'disable'
      # use attr instead of prop, because prop does not work with twitter bootstrap button
      $parent.find('input,textarea,select,button,.btn').removeAttr('disabled')
      $parent.find('.select2').select2('enable')
    else
      $parent.show(duration)
  else
    if method == 'disable'
      # use attr instead of prop, because prop does not work with twitter bootstrap button
      $parent.find('input,textarea,select,button,.btn').attr('disabled', 'disabled')
      $parent.find('.select2').select2('disable')
    else
      $parent.hide(duration)

showOrHideDependentFields = (duration = 'fast') ->
  $select = $(this)

  # fields that depend on a select option
  $(".js-dependent-fields[data-select-id=#{$select.attr('id')}]").each ->
    $this = $(this)
    # use attr here instead of data because we do not want jquery to cast the string into js types
    showOrHide = _.contains($this.attr('data-option-value').split('|'), $select.val())
    toggle($this, showOrHide, $this.data('method'), duration)

  # fields that depend on a checkbox
  $(".js-dependent-fields[data-checkbox-id=#{$select.attr('id')}]").each ->
    $this = $(this)
    showOrHide = $this.data('checkbox-value') == $select.is(':checked')
    toggle($this, showOrHide, $this.data('method'), duration)

bind = ->
  $('select').each _.partial(showOrHideDependentFields, 0)
  $('select').change showOrHideDependentFields

  $('input[type=checkbox]').each _.partial(showOrHideDependentFields, 0)
  $('input[type=checkbox]').change showOrHideDependentFields


@DependentFields = {
  bind
}