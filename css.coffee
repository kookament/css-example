selectors =
  'class': 
    desc: '.class'
    selector: '.class'
  'id': 
    desc: '#id'
    selector: '#id'

escape = (text) -> $('<div/>').text(text).html()

$.fn.inline = (indent = 0) ->
  s = ''
  @each ->
    open = @outerHTML.split('\n')[0]
    close = "</#{@nodeName.toLowerCase()}>"
    whitespace = new Array(4 * indent).join('&nbsp;')

    $(@).children().inline(indent + 1)

    open = "<div class='open tag'>#{whitespace}#{escape(open)}</div>"
    close = "<div class='close tag'>#{whitespace}#{escape(close)}</div>"

    $(@).html "#{open}#{@.innerHTML}#{close}"
  return @

$(document).ready ->
  opt_template = Handlebars.compile($('#option-template').html())
  $opts = $('#options')
  for k, v of selectors
    $opts.append opt_template v
  $('#display').children().inline()
  $('.selector-option').click ->
    $('.selector-option').removeClass 'selected'
    $(@).addClass 'selected'

    $('.highlighted').removeClass 'highlighted'
    $('#display').find($(@).data('selector')).find('> .tag').addClass 'highlighted'

  
