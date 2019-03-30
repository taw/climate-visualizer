import Sun from '../src/sun'
import Cell from '../src/cell'
import {test, assert-equal} from 'imba-spec'

test "Cell" do
  test "initializes" do
    let sun = Sun.new
    let cell = Cell.new(sun, 51.0)
    assert-equal cell:_temp, 0
