# This is the worst testing library ever, but we need to start somewhere

export def test(msg, block)
  console.log(msg)
  try
    block()
  catch e
    console.log("ERROR: {e}")

export def assert-eq(a, b)
  if a === b
    console.log("OK")
  else
    console.log("FAIL: {a} != {b}")
