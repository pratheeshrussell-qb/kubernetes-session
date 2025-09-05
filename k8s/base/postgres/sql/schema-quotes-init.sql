DO $$
BEGIN
IF NOT EXISTS (
    SELECT 1 
    FROM information_schema.tables 
    WHERE table_schema = 'quotes' AND table_name = 'messages') THEN

CREATE SCHEMA IF NOT EXISTS quotes;

CREATE TABLE IF NOT EXISTS quotes.messages (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    author VARCHAR(255)
);


-- seed data
INSERT INTO quotes.messages (text, author) VALUES
('The greatest glory in living lies not in never falling, but in rising every time we fall.', 'Nelson Mandela'),
('The way to get started is to quit talking and begin doing.', 'Walt Disney'),
('Life is what happens when you’re busy making other plans.', 'John Lennon'),
('Get busy living or get busy dying.', 'Stephen King'),
('You have within you right now, everything you need to deal with whatever the world can throw at you.', 'Brian Tracy'),
('Believe you can and you’re halfway there.', 'Theodore Roosevelt'),
('The only impossible journey is the one you never begin.', 'Tony Robbins'),
('Act as if what you do makes a difference. It does.', 'William James'),
('Success is not how high you have climbed, but how you make a positive difference to the world.', 'Roy T. Bennett'),
('What lies behind us and what lies before us are tiny matters compared to what lies within us.', 'Ralph Waldo Emerson'),
('The future belongs to those who believe in the beauty of their dreams.', 'Eleanor Roosevelt'),
('It does not matter how slowly you go as long as you do not stop.', 'Confucius'),
('You are never too old to set another goal or to dream a new dream.', 'C.S. Lewis'),
('The only limit to our realization of tomorrow will be our doubts of today.', 'Franklin D. Roosevelt'),
('The best way to predict the future is to create it.', 'Peter Drucker'),
('Your time is limited, so don’t waste it living someone else’s life.', 'Steve Jobs'),
('The only way to do great work is to love what you do.', 'Steve Jobs'),
('If you can dream it, you can do it.', 'Walt Disney'),
('Success usually comes to those who are too busy to be looking for it.', 'Henry David Thoreau'),
('Don’t watch the clock; do what it does. Keep going.', 'Sam Levenson'),
('The best revenge is massive success.', 'Frank Sinatra'),
('Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.', 'Albert Schweitzer'),
('I find that the harder I work, the more luck I seem to have.', 'Thomas Jefferson'),
('Success is walking from failure to failure with no loss of enthusiasm.', 'Winston S. Churchill'),
('What we fear doing most is usually what we most need to do.', 'Tim Ferriss'),
('Opportunities don’t happen. You create them.', 'Chris Grosser'),
('Don’t be afraid to give up the good to go for the great.', 'John D. Rockefeller'),
('I am not a product of my circumstances. I am a product of my decisions.', 'Stephen R. Covey'),
('Success is not in what you have, but who you are.', 'Bo Bennett'),
('Success is how high you bounce when you hit bottom.', 'George S. Patton'),
('The only place where success comes before work is in the dictionary.', 'Vidal Sassoon'),
('Success is not just about what you accomplish in your life, it’s about what you inspire others to do.', 'Unknown'),
('Success is not the absence of failure; it’s the persistence through failure.', 'Aisha Tyler'),
('Success is not a destination, but the road that you’re on.', 'Marilyn Monroe'),
('Success is not about being the best. It’s about always getting better.', 'Behdad Sami');




  END IF;
END $$;