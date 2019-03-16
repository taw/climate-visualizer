import Sun from './sun'
import Cell from './cell'

# FFS
import { scale-linear } from 'd3-scale';
import { interpolate-hcl } from 'd3-interpolate'

let sun = Sun.new

let lats = [-90, -85, -80, -75, -70, -65, -60, -55, -50, -45, -40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90]

let sunlight-scale = scale-linear()
  .domain([0, 1])
  .range(['#aaf', '#faa'])
  .interpolate(interpolate-hcl)

let temp-scale = scale-linear()
  .domain([-275, -50, 0, 50])
  .range(['#aaf', '#aaf', '#afa', '#faa'])
  .interpolate(interpolate-hcl)

tag Sunlight
  prop lat

  def render
    <self.box>
      for i in [0..11]
        let sl = sun.daily_radiation(lat, i/12.0) / 0.40
        <span.t style="background-color: {sunlight-scale(sl)}">
          Math.round(100 * sl)

tag CellBox
  prop lat
  def setup
    @cell = Cell.new(sun, lat)
    # Get some initial data
    for i in [0..1000]
      iterate

  def iterate
    @temps = []
    for i in [0..11]
      @temps.push @cell.temp
      for j in [0..29]
        let season = i * 30 + j
        @cell.iterate season
        # @temps.push @cell.temp

  def render
    <self.box>
      for i in [0..11]
        let t = @temps[i]
        <span.t style="background-color: {temp-scale(t)}">
          Math.round(t)

tag App
  def render
    <self>
      <header>
        "Climate Visualizer"
      <table>
        <tr>
          <th>
            "Latitude"
          <th>
            "Sunlight"
          <th>
            "Temperature"
        for lat in lats
          <tr>
            <td>
              lat
            <td>
              <Sunlight lat=lat>
            <td>
              <CellBox lat=lat>

Imba.mount <App>
