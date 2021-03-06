class Page
  execMatch = (regexps) ->
    elems = for elem in $("a, link").filter(':visible').reverse()
      [elem, $(elem).text().replace(/(^(\n|\s)+|(\s|\n)+$)/, "")]

    for regexp in regexps
      for [elem, value] in elems
        return clickElement(elem) if new RegExp(regexp, "i").test(value)
    null # FIXME for CoffeeScriptRedux

  @copySelected: ->
    text = getSelected()
    Clipboard.copy text
    CmdBox.set title: "[Copied]#{text.replace(/^(.{80})(.*)/, '$1...')}", timeout: 4000
  desc @copySelected, "Copy selected text"


  @showInfo: ->
    CmdBox.set title: document.title, timeout: 4000
  desc @showInfo, "Show page info"

  @next: ->
    execMatch Option.get("nextpattern")
  desc @next, "Paginate forward"
  @next.options = {
    nextpattern: {
      description: "Pattern(s) for next page"
      example: "set nextpattern+=^NextPage|››$ OR set nextpattern=['(下|后)一(页|頁)', '^Next$', '^>$']"
    }
  }

  @prev: ->
    execMatch Option.get("previouspattern")
  desc @prev, "Paginate backward"
  @prev.options = {
    previouspattern: {
      description: "Pattern(s) for prev page"
      example: "set previouspattern+=^PrevPage|‹‹$ OR set previouspattern=['(上|前)一(页|頁)', '^Prev(ious)?']"
    }
  }


root = exports ? window
root.Page = Page
