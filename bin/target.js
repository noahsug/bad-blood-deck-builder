(function() {
  var Target;

  Target = (function() {

    function Target(initHealth) {
      this.initHealth = initHealth;
      this.health = this.initHealth;
    }

    Target.prototype.isAlive = function() {
      return this.health > 0;
    };

    Target.prototype.defend = function() {};

    return Target;

  })();

  window.Target = Target;

}).call(this);
