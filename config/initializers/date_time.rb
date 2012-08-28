# -*- encoding : utf-8 -*-
[Time, Date].each do |clazz|
  eval "#{clazz}::MONTHNAMES = [nil] + %w(Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro)"
  eval "#{clazz}::DAYNAMES = %w(Domingo Segunda-Feira Terça-Feira Quarta-Feira Quinta-Feira Sexta-Feira Sábado)"
  eval "#{clazz}::ABBR_MONTHNAMES = [nil] + %w(Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez)"
  eval "#{clazz}::ABBR_DAYNAMES = %w(Dom Seg Ter Qua Qui Sex Sáb)"
end