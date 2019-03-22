import Sun from '../src/sun'
import {test, assert-eq} from './test'

let sun = Sun.new

test "#tilt" do
  assert-eq sun.tilt, 23.45

test "#declination" do
  assert-eq sun.declination(0.00), -23.45
  assert-eq sun.declination(0.25),   0.00
  assert-eq sun.declination(0.50), +23.45
  assert-eq sun.declination(0.75),   0.00
  assert-eq sun.declination(8.50), +23.45

test "#hour_angle" do
  assert-eq sun.hour_angle( 0), -180
  assert-eq sun.hour_angle( 1), -165
  assert-eq sun.hour_angle(12),    0
  assert-eq sun.hour_angle(23),  165
  assert-eq sun.hour_angle(24), -180
  assert-eq sun.hour_angle(-2),  150
  assert-eq sun.hour_angle(50), -150

# Tests here are a bit bad...

test "#altitude" do
  assert-eq sun.altitude(-23.45, 0.00, 12), 90
  assert-eq sun.altitude(     0, 0.25, 12), 90
  assert-eq sun.altitude( 23.45, 0.50, 12), 90
  assert-eq sun.altitude(     0, 0.75, 12), 90

test "#radiation" do
  assert-eq sun.radiation(-23.45, 0.00, 12), 1
  assert-eq sun.radiation(     0, 0.25, 12), 1
  assert-eq sun.radiation( 23.45, 0.50, 12), 1
  assert-eq sun.radiation(     0, 0.75, 12), 1

test "#daily_radation" do
  assert-eq sun.daily_radiation(0, 0.25), 0.31649

test "#daily_radation_memo" do
  assert-eq sun.daily_radiation_memo(0, 0.25), 0.31649
  assert-eq sun.daily_radiation_memo(10, 0.25), 0.311682
  assert-eq sun.daily_radiation_memo(0, 0.35), 0.30738
  assert-eq sun.daily_radiation_memo(20, 0.75), 0.297403
  assert-eq sun.daily_radiation_memo(10, 0.25), 0.311682

  assert-eq sun:_memo, Map.new([
    [0, Map.new([[0.25, 0.31649], [0.35, 0.30738]])],
    [10, Map.new([[0.25, 0.311682]])],
    [20, Map.new([[0.75, 0.297403]])],
  ])

# # C <-> K
# test "emissions" do
#   expect(Sun.emissions(30)).to eq(0.31649)

# test "equilibrium_temperature" do
#   expect(Sun.equilibrium_temperature(0.31649)).to eq(30)
