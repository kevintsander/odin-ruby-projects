require './methods.rb'

describe "#caesar_cipher" do
  it "('What a string!', 5) returns 'Bmfy f xywnsl!'" do
    expect(caesar_cipher('What a string!',5)).to eql('Bmfy f xywnsl!')
  end

  it "('Zzz', 1) returns 'Aaa' (crosses Z-A correctly)" do
    expect(caesar_cipher('Zzz',1)).to eql('Aaa')
  end

  it "('Aaa', -1) returns 'Zzz' (reverses A-Z correctly)" do
    expect(caesar_cipher('Aaa', -1)).to eql('Zzz')
  end

  it "('Bmfy f xywnsl!', -5) returns 'What a string!'" do
    expect(caesar_cipher('Bmfy f xywnsl!', -5)).to eql('What a string!')
  end

  it "nil input returns nil" do
    expect(caesar_cipher(nil, 1)).to be_nil
  end
  
  it "No shift returns same string" do
    expect(caesar_cipher("test123", 0)).to eql('test123')
  end

  it "Random string same forward and backward shift" do
    rand_string = (0...10).map { (65 + rand(26)).chr }.join
    shift = rand(-8..8)
    flipped = caesar_cipher(rand_string, shift)

    expect(caesar_cipher(flipped, -shift)).to eql(rand_string)
  end
end