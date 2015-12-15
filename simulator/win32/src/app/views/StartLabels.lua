--
-- Author: kwyxiong
-- Date: 2015-12-15 12:09:32
--
local OneByOneLabel = require("app.widgets.OneByOneLabel")
local StartLabels = class("StartLabels", cc.load("mvc").ViewBase)

function StartLabels:ctor()


	self:init()
end

function StartLabels:over()

	print("over")
end

function StartLabels:init()
	local c1 = cc.c4b(224, 112, 112, 255)
	local c2 = cc.c4b(255, 128, 255, 255)
	local tb = {
			{text = "……你知道端木吗？六年一班的端木，一个与之相关的传说。", fontColor = c1},
			{text = "端木……是一个人的名字吗？", fontColor = c2},
			{text = "是的。也许可能是姓氏，所以不一定是女生。曾经就有一个学生叫这个名字，有关端木的话题也是众说纷纭，就在距今二十六年前。", fontColor = c1},
			{text = "二十六年前……还真是久远啊。", fontColor = c2},
			{text = "总而言之，在二十六年前，我们学校的六年一班里有个叫端木的学生。我说……你真的没有听说过这件事情吗？", fontColor = c1},
			{text = "嗯……稍微等一下。端木？嗯。好像也有这么一说。你是从哪里听来的？", fontColor = c2},
			{text = "社团的前辈那儿。", fontColor = c1},
			{text = "是怎样的传说？", fontColor = c2},
			{text = "虽然不清楚是不是二十六年前的事情，但当时在六年级里有个叫端木的学生……啊，不过从我听到的感觉来说，那个端木是个男生。", fontColor = c1},
			{text = "然后，听说在那一年那个人所在的班级里发生了令人匪夷所思的事情。但那件事情需要保密，不能随便和别人谈论。所以，只能说到这儿了。", fontColor = c1},
			{text = "就这么点？", fontColor = c2},
			{text = "嗯。还说如果一时觉得好玩对别人说漏嘴的话就会有可怕的事情发生……这一定就是那个了。“七大离奇事件”的其中之一吧。", fontColor = c1},
			{text = "你这么认为吗？", fontColor = c2},
			{text = "不还有像是半夜在空无一人的音乐教室里响起了短笛的声音，中庭的荷花池里偶尔会伸出血淋淋的手……之类的传说吗？", fontColor = c1},
			{text = "说不定这就是其中第七个传说。好像还有一个是说在理科教室里的人体模型拥有真的心脏吧。", fontColor = c1},
			{text = "是的是的。", fontColor = c2},
			{text = "其他还有很多，我大概就知道有九到十个的，是我小学时的“七大离奇事件”。但是啊，端木的传说，没有包含在这其中……而且这个传说比起一般的“七大离奇事件”风格都要来得迥异啊。", fontColor = c1},
			{text = "嘿嘿。你知道详情吗？", fontColor = c2},
			{text = "差不多。", fontColor = c1},
			{text = "告诉我嘛。", fontColor = c2},
			{text = "即使会发生可怕的事情也要听吗？", fontColor = c1},
			{text = "那只是迷信而已。", fontColor = c2},
			{text = "也许吧。", fontColor = c1},
			{text = "那就告诉我吧。", fontColor = c2},
			{text = "不过，还是算了……", fontColor = c1},
			{text = "好嘛，好嘛，算我一生的请求……", fontColor = c2},
			{text = "你一生的请求，你到底是第几次说这话了啊。", fontColor = c1},
			{text = "嘿嘿。", fontColor = c2},
			{text = "真是的。知道后，也不要到处声张啊。", fontColor = c1},
			{text = "我绝对不会说的，我发誓。", fontColor = c2},
			{text = "嗯。那么。", fontColor = c1},
			{text = "太棒了。", fontColor = c2},
			{text = "端木那家伙，从一年级开始就一直备受关注。学习优异，体育万能，在绘画和音乐上也很有才华。而且外貌端庄，如果是男生的话应该就是眉清目秀吧，总之不管从哪方面来看端木都像是无懈可击的……", fontColor = c1},
			{text = "像那样的人，会不会令人讨厌？", fontColor = c2},
			{text = "没有，听说端木性格也是无可挑剔的。完全不会令人讨厌而且一点也不傲慢，对谁都非常温柔，而且平易近人，所以不管是老师还是学生，大家都很喜欢端木……总而言之，就是人气非常高。", fontColor = c1},
			{text = "嗯。没想到还真有这种人啊。", fontColor = c2},
			{text = "可是在升入六年级时因为重新排班而来到了一班的端木，却突然死了。", fontColor = c1},
			{text = "唉——", fontColor = c2},
			{text = "才只是第一个学期，端木都没能迎来自己十二岁的生日。听说就是这样。", fontColor = c1},
			{text = "为什么……意外吗？还是生病？", fontColor = c2},
			{text = "听说是航空事故——家人返乡探亲，回程的时候却意外遭遇了坠机。但也有不少其他的说法。……突如其来的悲剧，给班里的大家都带来了极大的打击。", fontColor = c1},
			{text = "那也是当然的啊。", fontColor = c2},
			{text = "大家都叫道，这真是无法相信！也有不少人喧嚷着，这一定是骗人的！还有很多人都泣不成声。班主任也不知该说什么好，一时间，整个教室沉浸在了异样的气氛之中……", fontColor = c1},
			{text = "突然有人大声说道，端木根本就没有死，大家快看，端木现在也好好的待在这里啊。", fontColor = c1},
			{text = "……", fontColor = c2},
			{text = "那人指向了端木的桌子，说道，你们看，端木不就在那里吗，明明就在那儿，端木还好好的活着坐在那里啊。", fontColor = c1},
			{text = "于是，班里接二连三地出现了赞同此人的学生。是真的，端木没有死，还活着，现在也在这里……", fontColor = c1},
			{text = "这是什么意思？", fontColor = c2},
			{text = "从那以后班上所有的学生一直装成“端木还活着”的样子。听说老师也是全力协助的。还说道，没错，正如大家所说，端木并没有死。", fontColor = c1},
			{text = "至少还作为这个教室的一员至今也好好地活着。从今往后，大家也要共同努力，争取一起毕业吧。……话说，差不多就是这种感觉吧。", fontColor = c1},
			{text = "虽然故事听起来不错，但总觉得有点不舒服。", fontColor = c2},
			{text = "结果，六年一班的学生就这样度过了他们的小学生活。端木的桌子也像以前那样摆放着。大家一有机会就和端木聊天，又或是一起玩闹一起回家……", fontColor = c1},
			{text = "当然，这一切都是假装的。之后，在毕业典礼上，校长也特意为端木安排了位置……", fontColor = c1},
			{text = "嗯。这果然是个不错的故事吧。", fontColor = c2},
			{text = "基本上是的，在某种程度上，这个故事已经能算是美谈了。可是，最后却留下了一个恐怖的结局。", fontColor = c1},
			{text = "嗯？是什么？", fontColor = c2},
			{text = "在毕业典礼之后，大家集体在教室里拍照留念。后来，大家看着洗好的照片时，都发现了一件事。就是在集体合照的角落里，出现了本不该出现的端木。", fontColor = c1},
			{text = "如同死人般苍白的脸，和大家一同笑着……", fontColor = c1},
		}

	local index = 1
	local touchCallback
	touchCallback = function() 
			self.curLabel:removeSelf()
			index = index + 1
			if tb[index] then
				self.curLabel = OneByOneLabel.new({text = tb[index].text, fontColor = tb[index].fontColor,
				touchCallback = touchCallback
				})
					:move(50 , 300)
					:addTo(self)
			else
				self:over()
			end
		end
	self:runAction(cc.Sequence:create(
			cc.DelayTime:create(2),
			cc.CallFunc:create(function() 
					self.curLabel = OneByOneLabel.new({text = tb[index].text, fontColor = tb[index].fontColor,
						touchCallback = touchCallback
						})
							:move(50 , 300)
							:addTo(self)	
				end)
		))	

end


return StartLabels