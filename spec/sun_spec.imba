import Sun from '../src/sun'
import {test, assert-equal} from 'imba-spec'

let sun = Sun.new

test "Sun" do
  test "#tilt" do
    assert-equal sun.tilt, 23.45

  test "#declination" do
    assert-equal sun.declination(0.00), -23.45
    assert-equal sun.declination(0.25),   0.00
    assert-equal sun.declination(0.50), +23.45
    assert-equal sun.declination(0.75),   0.00
    assert-equal sun.declination(8.50), +23.45

  test "#hour_angle" do
    assert-equal sun.hour_angle( 0), -180
    assert-equal sun.hour_angle( 1), -165
    assert-equal sun.hour_angle(12),    0
    assert-equal sun.hour_angle(23),  165
    assert-equal sun.hour_angle(24), -180
    assert-equal sun.hour_angle(-2),  150
    assert-equal sun.hour_angle(50), -150

  # its here are a bit bad...

  test "#altitude" do
    assert-equal sun.altitude(-23.45, 0.00, 12), 90
    assert-equal sun.altitude(     0, 0.25, 12), 90
    assert-equal sun.altitude( 23.45, 0.50, 12), 90
    assert-equal sun.altitude(     0, 0.75, 12), 90

  test "#radiation" do
    assert-equal sun.radiation(-23.45, 0.00, 12), 1
    assert-equal sun.radiation(     0, 0.25, 12), 1
    assert-equal sun.radiation( 23.45, 0.50, 12), 1
    assert-equal sun.radiation(     0, 0.75, 12), 1

  test "#daily_radation" do
    assert-equal sun.daily_radiation(0, 0.25), 0.31649

  test "#daily_radation_memo" do
    assert-equal sun.daily_radiation_memo(0, 0.25), 0.31649
    assert-equal sun.daily_radiation_memo(10, 0.25), 0.311682
    assert-equal sun.daily_radiation_memo(0, 0.35), 0.30738
    assert-equal sun.daily_radiation_memo(20, 0.75), 0.297403
    assert-equal sun.daily_radiation_memo(10, 0.25), 0.311682

    assert-equal sun:_memo, Map.new([
      [0, Map.new([[0.25, 0.31649], [0.35, 0.30738]])],
      [10, Map.new([[0.25, 0.311682]])],
      [20, Map.new([[0.75, 0.297403]])],
    ])

# # C <-> K
# test "emissions" do
#   expect(Sun.emissions(30)).to eq(0.31649)

# test "equilibrium_temperature" do
#   expect(Sun.equilibrium_temperature(0.31649)).to eq(30)
