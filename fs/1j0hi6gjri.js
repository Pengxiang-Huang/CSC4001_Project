name = 'golbal'
var obj = {
  name: 'local',
  p: function () {
    print(this.name);
  }
}
obj.p()
var test = obj.p
test()