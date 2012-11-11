
-- (1) モナドとして扱う型を定義
newtype Counter a = Counter { getCount :: (a, Int) }

-- (2) Monad のインスタンスを定義
instance Monad Counter where
	return x = Counter (x, 1)
	(Counter (x, c)) >>= f = let (y, _) = getCount(f x) in Counter (y, c + 1)

append :: String -> String -> Counter String
append s x = return (x ++ s)

-- Counter モナドの利用
main = do
	-- ("a",1)
	print $ getCount $ return "a"

	-- ("ab",2)
	print $ getCount $ return "a" >>= append "b"

	-- ("abc",3)
	print $ getCount $ return "a" >>= append "b" >>= append "c"