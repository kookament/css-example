selectors =
  'class': 
    label: '.%class/%'
    selector: '.list-item'
  'id': 
    label: '#%id/%'
    selector: '#list'
  '*':
    label: '%*/%'
    selector: '*'
  'tag':
    label: '%tag/%'
    selector: 'div'

interpolateLabel = (l) -> l.replace('/%', '</i>').replace('%', '<i>')

escape = (text) -> $('<div/>').text(text).html()

$.fn.inline = (indent = 0) ->
  s = ''
  @each ->
    open = @outerHTML.split('\n')[0]
    close = "</#{@nodeName.toLowerCase()}>"
    whitespace = new Array(4 * indent).join('&nbsp;')

    $this = $(@)
    if $this.children().length
      $this.children().inline(indent + 1)
      open = "<div class='open tag'>#{whitespace}#{escape(open)}</div>"
      close = "<div class='close tag'>#{whitespace}#{escape(close)}</div>"
      $this.html "#{open}#{@.innerHTML}#{close}"
    else
      # Here, 'open' is actually the whole tag.
      $this.html "<div class='open close tag'>#{whitespace}#{escape(open)}</div>"
  return @

$(document).ready ->
  opt_template = Handlebars.compile($('#option-template').html())
  $opts = $('#options')
  for k, v of selectors
    $opts.append opt_template { label: interpolateLabel(v.label), selector: v.selector}
  $('#display').children().inline()
  $('.selector-option').click ->
    $('#display').addClass 'something-selected'
    $('.selector-option').removeClass 'selected'
    $(@).addClass 'selected'

    $('.highlighted').removeClass 'highlighted'
    $('#display').find($(@).data('selector')).find('> .tag').addClass 'highlighted'

  
