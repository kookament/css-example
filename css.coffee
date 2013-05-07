selectors =
  class: '.class'
  id: '#id'

$(document).ready ->
  opt_template = Handlebars.compile($('#option-template').html())
  $opts = $('.options')
  for k, v of selectors
    $opts.append opt_template { type: k, desc: v}
    