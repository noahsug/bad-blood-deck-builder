(function() {
  var Target,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Target = (function(_super) {

    __extends(Target, _super);

    function Target(initHealth) {
      this.initHealth = initHealth;
      Target.__super__.constructor.call(this);
      this.health = this.initHealth;
    }

    Target.prototype.isAlive = function() {
      return this.health > 0;
    };

    Target.prototype.onAttacked = function(card, dmg) {
      this.emit('attacked', card);
      return this.takeDmg(dmg);
    };

    Target.prototype.takeDmg = function(dmg) {
      return this.health -= dmg;
    };

    Target.prototype.changeEffect = function() {};

    return Target;

  })(EventEmitter);

  window.Target = Target;

}).call(this);
