# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 company_info= [["维多利亚的秘密","纽约"] ,["伊林模特","上海"] ,
 ["新丝路模特","北京"] ,["凯渥模特","台北"] ,["SOD","休斯敦"] ,
 ["Prestige","四川"] ,["TVB","香港"] ,["London Heart","伦敦"] ,
 ["奥修之旅","新德里"]]

jobs_info = [["男模特","男176cm以上；28歲以下。五官端正-有自信、活潑、口條好，對模特工作有興趣者.01.幸福與自由的工作氛圍（這是我們認為公司最大的優點，只要您願意融入我們，這會是像家一樣自在的快樂職場） 02.彈性上下班（早上9:00上班，晚上18:00下班，上班可緩衝至9:30前上班，下班則延至18:30，讓您上班可以更Easy！） 03.週休二日（除特殊情況及工作性質需要輪班者外，員工皆享週休二日及國定例假） 04.勞健保（除全勤獎金不納入固定薪資計算外，公司將以您本薪加上所有津貼的總合薪資去投保對應的勞健保級距，完全不偷雞） "
],[ "女模特","女163cm以上；28歲以下。五官端正-有自信、活潑、口條好，對模特工作有興趣者.配合自身的時間狀況彈性安排上班 01.勞退薪資提撥退休帳戶（公司依法針對您實際薪資的6％額外繳交政府，不巧立名目內扣員工薪資） 02.團體保險（新人報到便享有團體保險，依年資共分三個等級機動性調整，讓員工多一層的保障！ "
],["平面杂志模特","26歲以下。五官端正-有自信、活潑、口條好，短发，有冷酷有热情，表情丰富。配合自身的時間狀況彈性安排上班 01.出差意外險（因公出國不分年資，副理級以下員工每人投保新台幣500萬，經理級以上員工每人投保新台幣1,000萬意外險） 02.健康檢查（年資滿一年以上，公司每年提供一次委外專業健檢中心的診斷服務，若達到一定主管職級的標準，公司會針對想額外自費增加健檢項目之主管，提撥一定金額實報實銷的經費補助） 03.全勤獎金（每月全勤獎金2,000元，該月若您遲到或請假，可用個人剩餘特休或補休時數扣抵，若能補足當月缺班，依然算您全勤） "
],["广告模特","女150～170cm；男165～185cm；14～65歲,能配合厂商外形需求！不限体型 01.幸福與自由的工作氛圍（這是我們認為公司最大的優點，只要您願意融入我們，這會是像家一樣自在的快樂職場） "
],["演艺类模特","女160～170cm；男175～185cm；14～25歲,勇於表現自己！熱愛表演工作！對戲劇演出有興趣者！專業設計師打造彩妝、美髮造型，著風格時尚禮服。"
]]


puts "this seed will create an admin account automatically, 10 public jobs, and 10 hidden jobs"

create_account = User.create([email: "a@a.com", password:"123456",password_confirmation: "123456",is_admin:"true", name:"Admin"])

puts "Admin account created."

create_account_user = User.create([email: "b@b.com", password:"123456",password_confirmation: "123456",is_admin:"false", name:"美女"])

puts "User account created."

create_jobs = for i in 1..30 do
	job_test=jobs_info[rand(0..4)]
	company_test=company_info[rand(0..8)]
	Job.create!([title: job_test[0],description: job_test[1], wage_upper_bound: rand(50..99)*100,
		wage_lower_bound: rand(10..49)*100, is_hidden:"false",city:company_test[1],company:company_test[0]])
end

puts "30 Public jobs created."

create_jobs = for i in 1..30 do
	job_test=jobs_info[rand(0..4)]
	company_test=company_info[rand(0..8)]
	Job.create!([title: job_test[0],description: job_test[1], wage_upper_bound: rand(50..99)*100,
		wage_lower_bound: rand(10..49)*100, is_hidden:"true",city:company_test[1],company:company_test[0]])
end

puts "30 Hidden jobs created."
