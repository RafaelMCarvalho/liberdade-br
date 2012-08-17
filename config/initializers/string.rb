# -*- encoding : utf-8 -*-
class String
  def downcase_with_accents
    return nil if self.nil?
    str = self.downcase
    str.tr!('ÁÉÍÓÚ', 'áéíóú')
    str.tr!('ÀÈÌÒÙ', 'àèìòù')
    str.tr!('ÄËÏÖÜ', 'äëïöü')
    str.tr!('ÂÊÎÔÛ', 'âêîôû')
    str.tr!('ÃẼĨÕŨ', 'ãẽĩõũ')
    str
  end
end
