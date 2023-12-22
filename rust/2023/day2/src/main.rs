use std::fs;

const RED_CUBES: usize = 12;
const GREEN_CUBES: usize = 13;
const BLUE_CUBES: usize = 14;
const GAME_INDEX: usize = 0;
const GAME_PREFIX: &str = "Game ";

fn main() {
    println!("Part one answer: {:?}", solve_part1("input.txt"));
}

fn solve_part1(input_file_path: &str) -> usize {
    fs::read_to_string(input_file_path)
        .expect("Unable to read file contents")
        .lines()
        .map(|game_input| part1_parse(game_input))
        .sum()
}

/// Take raw input for each line of part one and return the game number
/// if all games eligible. Otherwise, return zero.
fn part1_parse(input_str: &str) -> usize {
    let mut games: Vec<&str> = input_str.split(&[':', ';'][..]).map(|v| v.trim()).collect();

    let game_int = games
        .remove(GAME_INDEX)
        .strip_prefix(GAME_PREFIX)
        .expect("Unable to strip game prefix.")
        .parse::<usize>()
        .expect("Unable to parse to integer");

    if games.iter().all(|&game_input| game_eligible(game_input)) {
        return game_int;
    }
    0
}

/// Check a raw string of all subsets of a game and return
/// a boolean for whether the game could happen or not
fn game_eligible(raw_input: &str) -> bool {
    for subset in raw_input.split(", ") {
        match check_cubes(subset) {
            true => continue,
            false => return false,
        }
    }
    true
}

/// Check a single string with a digit and color
/// against the values given in the contsants above
fn check_cubes(raw_input: &str) -> bool {
    let mut v: Vec<&str> = raw_input.split_whitespace().collect();

    let color = v.pop().expect("Unable to pop color");
    let count = v
        .pop()
        .expect("Unable to pop color")
        .parse::<usize>()
        .expect("Unable to parse to int");

    match color {
        "green" => {
            if count > GREEN_CUBES {
                return false;
            }
        }
        "red" => {
            if count > RED_CUBES {
                return false;
            }
        }
        "blue" => {
            if count > BLUE_CUBES {
                return false;
            }
        }
        _ => println!("Unknown color!"),
    }
    true
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_solve_part1() {
        assert_eq!(solve_part1("test_input.txt"), 8);
    }

    #[test]
    fn test_part1_parse() {
        assert_eq!(
            part1_parse("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"),
            2
        );

        assert_eq!(
            part1_parse("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"),
            0
        );

        assert_eq!(
            part1_parse("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"),
            0
        );

        assert_eq!(
            part1_parse("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"),
            5
        );
    }

    #[test]
    fn test_game_eligible() {
        assert!(game_eligible(
            "1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
        ));
        assert!(!game_eligible(
            "1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
        ));
    }

    #[test]
    fn test_check_cubes() {
        assert!(check_cubes("5 green"));
        assert!(check_cubes("1 blue"));
        assert!(check_cubes("7 red"));

        assert!(!check_cubes("15 blue"));
        assert!(!check_cubes("14 green"));
        assert!(!check_cubes("13 red"));
    }
}