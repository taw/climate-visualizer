let ck = 273.15
let factor = 0.000000000035
let capacity = 0.2

class Cell
  prop temp

  def initialize(sun, lat)
    @sun = sun
    @lat = lat
    @temp = 0.0 # Start
    @sun-memo = Map.new

  # 360 might be super slow, especially without proper memoization
  def iterate(season)
    let e = Math.pow(@temp + ck, 4) * factor
    unless @sun-memo.has season
      @sun-memo.set season, @sun.daily_radiation(@lat, season / 360.0)

    let i = @sun-memo.get season

    @temp += (i - e) / capacity
    if @temp < -ck
      @temp = -ck

export default Cell
