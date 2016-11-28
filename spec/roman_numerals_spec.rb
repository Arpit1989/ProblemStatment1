require_relative '../roman_numerals'
describe RomanNumerals do
  base_digits = {
      1    => 'I',
      4    => 'IV',
      5    => 'V',
      9    => 'IX',
      10   => 'X',
      40   => 'XL',
      50   => 'L',
      90   => 'XC',
      100  => 'C',
      400  => 'CD',
      500  => 'D',
      900  => 'CM',
      1000 => 'M'
  }

  describe ".to_roman" do
    base_digits.each do |decimal, roman|
      it "converts the decimal value #{decimal} to the roman value #{roman}" do
        expect(RomanNumerals.to_roman(decimal)).to eq(roman)
      end
    end
    it "converts decimals" do
      expect(RomanNumerals.to_roman(244)).to eq('CCXLIV')
      expect(RomanNumerals.to_roman(45)).to eq('XLV')
    end
  end
  describe ".to_decimal" do
    base_digits.each do |decimal, roman|
      it "converts the roman value #{roman} to the decimal value #{decimal}" do
        expect(RomanNumerals.to_decimal(roman)).to eq(decimal)
      end
    end
    it "converts roman numerals" do
      expect(RomanNumerals.to_decimal('CCXLIV')).to eq(244)
      expect(RomanNumerals.to_decimal('XLV')).to eq(45)
    end
    it "handles lower-case roman numerals" do
      expect(RomanNumerals.to_decimal('ccxliv')).to eq(244)
      expect(RomanNumerals.to_decimal('xlv')).to eq(45)
    end
  end
end