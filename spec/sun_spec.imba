import Sun from '../src/sun'
import { describe, declare, it, expect } from 'imba-spec'

let sun = Sun.new

describe "Sun" do
  declare "sun" do
    Sun.new

  describe "#tilt" do
    it "defaults to Earth tilt" do |t|
      expect.equal t.sun.tilt, 23.45

  describe "#declination" do
    it "varies based on tilt and season" do |t|
      expect.equal t.sun.declination(0.00), -23.45
      expect.equal t.sun.declination(0.25),   0.00
      expect.equal t.sun.declination(0.50), +23.45
      expect.equal t.sun.declination(0.75),   0.00
      expect.equal t.sun.declination(8.50), +23.45

  it "#hour_angle" do |t|
    expect.equal t.sun.hour_angle( 0), -180
    expect.equal t.sun.hour_angle( 1), -165
    expect.equal t.sun.hour_angle(12),    0
    expect.equal t.sun.hour_angle(23),  165
    expect.equal t.sun.hour_angle(24), -180
    expect.equal t.sun.hour_angle(-2),  150
    expect.equal t.sun.hour_angle(50), -150

  # its here are a bit bad...

  it "#altitude" do |t|
    expect.equal t.sun.altitude(-23.45, 0.00, 12), 90
    expect.equal t.sun.altitude(     0, 0.25, 12), 90
    expect.equal t.sun.altitude( 23.45, 0.50, 12), 90
    expect.equal t.sun.altitude(     0, 0.75, 12), 90

  it "#radiation" do |t|
    expect.equal t.sun.radiation(-23.45, 0.00, 12), 1
    expect.equal t.sun.radiation(     0, 0.25, 12), 1
    expect.equal t.sun.radiation( 23.45, 0.50, 12), 1
    expect.equal t.sun.radiation(     0, 0.75, 12), 1

  it "#daily_radation" do |t|
    expect.equal t.sun.daily_radiation(0, 0.25), 0.31649

  it "#daily_radation_memo" do |t|
    expect.equal t.sun.daily_radiation_memo(0, 0.25), 0.31649
    expect.equal t.sun.daily_radiation_memo(10, 0.25), 0.311682
    expect.equal t.sun.daily_radiation_memo(0, 0.35), 0.30738
    expect.equal t.sun.daily_radiation_memo(20, 0.75), 0.297403
    expect.equal t.sun.daily_radiation_memo(10, 0.25), 0.311682
    expect.equal t.sun:_memo, Map.new([
      [0, Map.new([[0.25, 0.31649], [0.35, 0.30738]])],
      [10, Map.new([[0.25, 0.311682]])],
      [20, Map.new([[0.75, 0.297403]])],
    ])
