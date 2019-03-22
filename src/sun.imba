# Radians are annoying

let pi = Math:PI

let ck = 273.15
let factor = 0.31649 * Math.pow((1 / (30 + 273.15)), 4)

let def dcos deg
  Math.cos(deg / 180 * pi)

let def dsin deg
  Math.sin(deg / 180 * pi)

let def roundn v, n
  let ten_n = Math.pow(10, n)
  Math.round(v * ten_n) / ten_n

let def round2 v
  # roundn v, 2
  Math.round(v * 100) / 100

let def round6 v
  # roundn v, 6
  Math.round(v * 1000000) / 1000000

# % in js is broken because js is a stupid language
let def to24(v)
  v %= 24
  v += 24
  v % 24

class Sun
  prop tilt

  def initialize(tilt = 23.45)
    @tilt = tilt
    @memo = Map.new

  # 0 - winter, 0.5 summer
  def declination(season)
    round2 (-Math.cos(season * 2 * pi) * @tilt)

  # 0 - midnight, 12 - noon, 24 - midnight
  def hour_angle(hour)
    round2( (to24(hour) - 12) * 15 )

  def altitude(lat, season, hour)
    let sin_aa = sin_altitude(lat, season, hour)
    round2( Math.asin(sin_aa) * 180.0 / Math:PI )

  def sin_altitude(lat, season, hour)
    let d = declination(season)
    let ha = hour_angle(hour)
    round6(
      dcos(lat) * dcos(d) * dcos(ha) +
      dsin(lat) * dsin(d)
    )

  def radiation(lat, season, hour)
    Math.max(0, sin_altitude(lat, season, hour))

  def daily_radiation(lat, season)
    let e = 0
    for h in [0..23]
      e += radiation(lat, season, h)
    round6 (e / 24.0)

  # 2-stage memo
  def daily_radiation_memo(lat, season)
    let latmemo
    if @memo.has(lat)
      latmemo = @memo.get(lat)
    else
      latmemo = Map.new
      @memo.set(lat, latmemo)

    if latmemo.has(season)
      latmemo.get(season)
    else
      let result = daily_radiation(lat, season)
      latmemo.set(season, result)
      result

export default Sun
