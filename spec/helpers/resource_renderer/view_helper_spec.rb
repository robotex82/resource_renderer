require 'rails_helper'

module ResourceRenderer
  describe ViewHelper do
    describe '#render_resource' do
      it { expect(helper).to respond_to(:render_resource )}

      describe 'foo' do
        before(:each) do
          @post = OpenStruct.new(title: 'This is a post')
          @block = Proc.new { |renderer| renderer.display :title }
        end

        it { expect(helper.render_resource(@post, &@block)).to include(@post.title) }
      end
    end
  end
end
