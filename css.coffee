selectors = [
  {
    group: 'Basic'
    examples: [
      { label: '%*/%',                   selector: '*',              spec: 2 }
      { label: '%tag/%',                 selector: 'div',            spec: 1 }
      { label: '.%class/%',              selector: '.list-item',     spec: 1 }
      { label: '#%id/%',                 selector: '#main-list',     spec: 1 }
      { label: '%element/%, %element/%', selector: 'header, footer', spec: 1 }
    ]
  }, {
    group: 'Ordering'
    examples: [
      { label: '%element/% %element/%',   selector: 'article div',   spec: 1 }
      { label: '%element/% > %element/%', selector: 'article > div', spec: 2 }
      { label: '%element/% + %element/%', selector: 'div + ul',      spec: 2 }
      { label: '%element/% ~ %element/%', selector: 'div ~ ul',      spec: 3 }
    ]
  }, {
    group: 'Attribute'
    examples: [
      { label: '[%attribute/%]',           selector: '[name]',            spec: 2 }
      { label: '[%attribute/%=%value/%]',  selector: '[name="list one"]', spec: 2 }
      { label: '[%attribute/%~=%value/%]', selector: '[name~=is]',        spec: 2 }
      { label: '[%attribute/%|=%value/%]', selector: '[name|=this]',      spec: 2 }
    ]
  }
]

escape = (text) -> $('<div/>').text(text).html()

Handlebars.registerHelper 'formatLabel', (l) -> l.replace(/\/%/g, '</i>').replace(/%/g, '<i>')

$.fn.inline = (indent = 0) ->
  @each ->
    open = @outerHTML.split('\n')[0]
    close = "</#{@nodeName.toLowerCase()}>"
    whitespace = new Array(4 * indent).join('&nbsp;')

    $this = $(@)
    if $this.children().length
      $this.children().inline(indent + 1)
      open = "<span class='open tag'>#{whitespace}#{escape(open)}</span>"
      close = "<span class='close tag'>#{whitespace}#{escape(close)}</span>"
      $this.html "#{open}#{@.innerHTML}#{close}"
    else
      # Here, 'open' is actually the whole tag, but only because we make tags that
      # contain only text nodes a single line.
      $this.html "<span class='open close tag'>#{whitespace}#{escape(open)}</span>"
  return @

$(document).ready ->
  opt_template = Handlebars.compile($('#option-template').html())
  $opts = $('#options').html opt_template(selectors: selectors)
  $('#display').children().inline()

  $('.option').click ->
    $('#display').addClass 'something-selected'
    $('.option').removeClass 'selected'
    $(@).addClass 'selected'

    $('.highlighted').removeClass 'highlighted'
    $('#display').find($(@).data('selector')).find('> .tag').addClass 'highlighted'

  
