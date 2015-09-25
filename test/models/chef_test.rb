require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    
    def setup
        @chef = Chef.new(chef_name: "ama", email: "ama.gh@yahoo.com")
    end
    
    test "chef should be valid" do
        assert @chef.valid?
    end
    
    test "chef name should be present" do
        @chef.chef_name = " "
        assert_not @chef.valid?
    end
    
    test "chef name should not be too logng" do
        @chef.chef_name = "a"*41
        assert_not @chef.valid?
    end
    
    test "chef name shoudl not be too short" do
        @chef.chef_name = "ab"
        assert_not @chef.valid?
    end
    
    test "email must be present" do
        @chef.email = " "
        assert_not @chef.valid?
    end
    
    test "email should not be with in hundres" do
        @chef.email = "a"*101 + "ama.ghya@gmail.com"
        assert_not @chef.valid?
    end
    
    test "email address shoudl be unique" do
        dup_chef = @chef.dup
        dup_chef.email = @chef.email.upcase
        @chef.save
        assert_not dup_chef.valid?
    end
    
    test "email should accept valid addresses" do
        valid_address = %w[user@eee.com R_TDD-@eee.hello.org user@example.com first.last@ee.co laura+joe@kkk.com]
        valid_address.each do |va|
            @chef.email = va
            assert @chef.valid?, '#{va.inspect} should be valid'
        end
    end
    
    test "email should reject invalide address" do
        invalid_address = %w[user@example,com user_at_ee.org user.name@example. cc@l_am_.com foo@ee+our.com ]
        invalid_address.each do |ia|
            @chef.email = ia
            assert_not @chef.valid?, '#{ia.inspect} should be valid'
        end    
    end
    
end