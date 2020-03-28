/* Ternary relation involving Business and User [[ENTITY]] */
CREATE TABLE IF NOT EXISTS Tip (
	id       SERIAL    PRIMARY KEY,
	business CHAR(22)  REFERENCES Business(id),
	user_id  CHAR(22)  REFERENCES Users(id),
	date     TIMESTAMP NOT NULL,
	text     TEXT      NOT NULL,
	likes    INTEGER   NOT NULL
);

CREATE OR REPLACE FUNCTION UpdateTip() RETURNS TRIGGER AS $UpdateTip$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            UPDATE business
            SET num_tips = num_tips + 1
            WHERE business.id = NEW.business;

            UPDATE users
            SET tip_count = tip_count + 1
            WHERE users.id = NEW.user_id;

            UPDATE users
            SET total_likes = total_likes + NEW.likes
            WHERE users.id = NEW.user_id;

            RETURN NEW;
        ELSEIF (TG_OP = 'DELETE') THEN
            UPDATE business
            SET num_tips = GREATEST(0, num_tips - 1)
            WHERE business.id = OLD.business;

            UPDATE users
            SET tip_count = GREATEST(0, tip_count - 1)
            WHERE users.id = OLD.user_id;

            UPDATE users
            SET total_likes = total_likes - OLD.likes
            WHERE users.id = NEW.user_id;
            
            RETURN OLD;
        ELSEIF (TG_OP = 'UPDATE') THEN
            UPDATE business
            SET num_tips = GREATEST(0, num_tips - 1)
            WHERE business.id = OLD.business;

            UPDATE business
            SET num_tips = num_tips + 1
            WHERE business.id = NEW.business;

            UPDATE users
            SET tip_count = GREATEST(0, tip_count - 1)
            WHERE users.id = OLD.user_id;
            
            UPDATE users
            SET tip_count = tip_count + 1
            WHERE users.id = NEW.user_id;

            UPDATE users
            SET total_likes = total_likes - OLD.likes
            WHERE users.id = OLD.user_id;

            UPDATE users
            SET total_likes = total_likes + NEW.likes
            WHERE users.id = NEW.user_id;

            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$UpdateTip$ LANGUAGE plpgsql;

CREATE TRIGGER CheckInInc
    AFTER INSERT OR UPDATE OR DELETE ON tip
    FOR EACH ROW
EXECUTE PROCEDURE UpdateTip();

