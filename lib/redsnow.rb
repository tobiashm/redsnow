require "redsnow/version"
require "redsnow/binding"
require "redsnow/blueprint"
require "ffi"

module RedSnow
  include Binding
  # parse
  #   parsing API Blueprint into Ruby objects
  # @param rawBlueprint [String] API Blueprint
  # @param options [Number] Parsing Options
  #
  # @return [Blueprint]
  def self.parse(rawBlueprint, options = 0)
    blueprint = FFI::MemoryPointer.new :pointer
    result = FFI::MemoryPointer.new :pointer
    ret = RedSnow::Binding.sc_c_parse(rawBlueprint, options, result, blueprint)

    blueprint = blueprint.get_pointer(0)
    result = result.get_pointer(0)

    bp = Blueprint.new(blueprint)

    return bp
  ensure
    RedSnow::Binding.sc_blueprint_free(blueprint)
    RedSnow::Binding.sc_result_free(result)
  end

end
