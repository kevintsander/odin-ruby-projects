require './methods.rb'

describe "#caesar_cipher" do
  it "('What a string!', 5) returns 'Bmfy f xywnsl!'" do
    expect(caesar_cipher('What a string!',5)).to eql('Bmfy f xywnsl!')
  end

  it "('Zzz', 1) returns 'Aaa' (crosses A-Z correctly)" do
    expect(caesar_cipher('Zzz',1)).to eql('Aaa')
  end

  it "('Aaa', -1) returns 'Zzz' (reverses A-Z correctly)" do
    expect(caesar_cipher('Aaa', -1)).to eql('Zzz')
  end
end