exports = window

exports.shuffle = (arr) ->
  i = arr.length
  if i is 0 then return false
  while --i
      j = Math.floor(Math.random() * (i+1))
      [arr[i], arr[j]] = [arr[j], arr[i]]
  return arr

exports.removeAtRandom = (arr) ->
  arr.splice(Math.random() * Math.floor(arr.length), 1)[0]

exports.removeAtIndexes = (arr, indexes) ->
  for index, i in indexes
    arr.splice(index - i, 1)[0]

exports.flipCoin = ->
  return Math.random() < .5

exports.pad = (text, width) ->
  if text.length is width
    text
  else if width is 0
    ''
  else if text.length > width
    text[0..width - 1]
  else
    text + (' ' for i in [text.length..width-1]).join('')
