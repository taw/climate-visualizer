import Sun from './sun'

let sun = Sun.new

let lats = [-90, -85, -80, -75, -70, -65, -60, -55, -50, -45, -40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90]

tag Sunlight
  prop lat

  def render
    <self>
      "Who knows #{lat}"

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
        for lat in lats
          <tr>
            <td>
              lat
            <td>
              <Sunlight lat=lat>

Imba.mount <App>
