-- MADE BY MARTIALTRADER (DEMOLISHSANITY / AESIRMALUS)
-- DON'T LEAK.

local UIS = game:GetService('UserInputService');
local Players = game:GetService('Players');

local Player = Players.LocalPlayer;
local PlayerGui = Player.PlayerGui;

local ChatScreenUI = PlayerGui:WaitForChild('Chat');
local BoxFrame = ChatScreenUI.Frame.ChatBarParentFrame.Frame.BoxFrame;

local MessageMode = BoxFrame.Frame.MessageMode;
local PlaceholderText = BoxFrame.Frame.TextLabel;
local ChatBar = BoxFrame.Frame.ChatBar;

_G.MACRO_TOGGLE = true;
_G.MIN_SPEED = 0.03;
_G.MAX_SPEED = 0.05;

local Keys = {
    --[[
        Make sure the last item on the Keys list doesn't have a comma.
        FORMAT: Key = 'Name',

        Ignore: <field: Key: string = Spell>       
    ]]
	Z = 'Avada Kedavra',
	X = 'Duro',
	C = 'Glacius'
};

function DisplayWords(message: string)
	PlaceholderText.Text = '';
	ChatBar.Text = 'To chat click here or press "/" key'
	
	ChatBar:CaptureFocus();
	
	ChatBar:ReleaseFocus();
	
	for i = 1, #message do
		ChatBar.Text = string.sub(message, 1, i);
		wait(math.random(_G.MIN_SPEED, _G.MAX_SPEED));
	end

	local _, Error = pcall(function()
		Players:Chat(message);
	end);

	if Error then
		warn(Error)
	end

	local A_1 = message;
	local A_2 = 'All';
	local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest;
	Event:FireServer(A_1, A_2);

	wait();

	PlaceholderText.Text = 'To chat click here or press "/" key';
	ChatBar.Text = 'To chat click here or press "/" key';

end

function InputBegan(Input: InputObject, GPE: boolean)
	if GPE then return nil end
	if not _G.MACRO_TOGGLE then return nil end

	if Input.UserInputType == Enum.UserInputType.Keyboard then
		for i, v in pairs(Keys) do
			local Key = i;
			local Spell = v;

			if Input.KeyCode == Enum.KeyCode[Key] then
				DisplayWords(Spell);
			end
		end
	end
end

UIS.InputBegan:Connect(InputBegan);
