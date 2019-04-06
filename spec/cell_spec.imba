import Sun from '../src/sun'
import Cell from '../src/cell'
import { describe, declare, it, assert-equal } from 'imba-spec'

describe "Cell" do
  it "initializes" do
    let sun = Sun.new
    let cell = Cell.new(sun, 51.0)
    assert-equal cell:_temp, 0
