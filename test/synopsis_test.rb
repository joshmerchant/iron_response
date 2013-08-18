require "test_helper"

class SynopsisTest < MiniTest::Unit::TestCase
  def test_synopsis_with_s3
    config = Configuration.keys
    batch  = IronResponse::Batch.new(config)
    
    batch.worker             = "test/workers/hello.rb"
    batch.params_array       = Array(1..4).map {|i| {number: i}}
    batch.create_code!

    results = batch.run!

    assert_equal batch.params_array.length, results.length

    results.select! {|r| !r.is_a?(IronResponse::Error)}
    
    binding.pry

    assert_equal Array, results.class
  end

  def test_synopsis_with_iron_cache
    config = Configuration.keys
    batch  = IronResponse::Batch.new(iron_io: config[:iron_io])
    
    batch.worker             = "test/workers/hello.rb"
    batch.params_array       = Array(1..4).map {|i| {number: i}}
    
    batch.create_code!

    results = batch.run!

    assert_equal batch.params_array.length, results.length

    results.select! {|r| !r.is_a?(IronResponse::Error)}

    binding.pry

    assert_equal Array, results.class
  end
end