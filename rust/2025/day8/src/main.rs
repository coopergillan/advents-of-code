// Advent of Code solver

use std::fs;

#[derive(Debug, PartialEq)]
struct TopLevelStructMultipleIntsPerLine {
    // For a graph type of problem use a vector of vectors
    input_data: Vec<Vec<usize>>,
}

impl TopLevelStructMultipleIntsPerLine {
    // For one value per line use a vector of integers
    // If negative numbers needed, change to usize
    fn new(input_data: Vec<Vec<usize>>) -> Self {
        TopLevelStructMultipleIntsPerLine { input_data }
    }

    fn from_file(file_path: &str) -> Self {
        // For reading each line into an array
        let raw_content = fs::read_to_string(file_path).expect("Unable to read file");

        let processed_contents: Vec<Vec<usize>> = raw_content
            .lines()
            .map(|line| {
                line.split(",")
                    .map(|v| v.parse::<usize>().expect("Unable to parse"))
                    .collect() // Inside Vec<usize> created here
            })
            .collect();

        println!(
            "Creating struct with processed contents: {:?}",
            processed_contents
        );
        Self::new(processed_contents)
    }
}

fn main() {
    println!("Hello world");
    let input_file = "test_input_multiple_ints_per_line.txt";

    let top_level = TopLevelStructMultipleIntsPerLine::from_file(input_file);

    // println!("Part 1 answer: {}", top_level.solve_part1());
    // println!("Part 2 answer: {}", top_level.solve_part2());
    dbg!(top_level);
}

#[derive(Clone, Debug, PartialEq)]
struct JunctionBox {
    x: usize,
    y: usize,
    z: usize,
}

impl JunctionBox {
    fn new() -> Self {
        JunctionBox { x: 0, y: 0, z: 0 }
    }

    fn from_vec(input_data: Vec<usize>) -> Self {
        Self {
            x: input_data[0],
            y: input_data[1],
            z: input_data[2],
        }
    }

    // Get a vector of JunctionBoxes from a file path of coordinates
    fn from_file(file_path: &str) -> Vec<JunctionBox> {
        let raw_content = fs::read_to_string(file_path).expect("Unable to read file");
        raw_content
            .lines()
            .map(|line| {
                JunctionBox::from_vec(
                    line.split(",")
                        .map(|v| v.parse::<usize>().expect("Unable to parse"))
                        .collect(),
                )
            })
            .collect()
    }

    fn distance_squared(&self, neighbor: &JunctionBox) -> usize {
        let x_squared = self.x.abs_diff(neighbor.x).pow(2);
        let y_squared = self.y.abs_diff(neighbor.y).pow(2);
        let z_squared = self.z.abs_diff(neighbor.z).pow(2);

        x_squared + y_squared + z_squared
    }
}

struct Playground {
    boxes: Vec<JunctionBox>,
}

impl Playground {
    //fn new() -> Self {
    //    Playground { boxes: Vec::new() }
    //}
    //
    //fn from_vec(boxes: Vec

    fn sorted_pairs(&self) -> Vec<(usize, usize)> {
        vec![(1, 2)]
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_junction_box_from_file() {
        let boxes = JunctionBox::from_file("test_input_multiple_ints_per_line.txt");
        assert_eq!(boxes.len(), 20);
        assert_eq!(
            boxes[0],
            JunctionBox {
                x: 162,
                y: 817,
                z: 812
            }
        );
        assert_eq!(
            boxes[19],
            JunctionBox {
                x: 425,
                y: 690,
                z: 689
            }
        );
    }

    #[test]
    fn test_distance_squared() {
        let a = JunctionBox {
            x: 162,
            y: 817,
            z: 812,
        };
        let b = JunctionBox {
            x: 425,
            y: 690,
            z: 689,
        };
        assert_eq!(a.distance_squared(&b), 100427);
    }

    #[test]
    fn test_distance_squared_is_resuable() {
        let a = JunctionBox {
            x: 162,
            y: 817,
            z: 812,
        };
        let b = JunctionBox {
            x: 425,
            y: 690,
            z: 689,
        };
        let c = JunctionBox {
            x: 906,
            y: 360,
            z: 560,
        };
        a.distance_squared(&b);
        assert_eq!(a.distance_squared(&c), 825889);
    }

    #[test]
    fn test_sorted_pairs_by_distance_ascending() {
        let boxes = JunctionBox::from_file("test_input_multiple_ints_per_line.txt");
        let playground = Playground { boxes };
        let pairs = playground.sorted_pairs();

        // Use the indexes of each box to denote a pair
        // These are the four examples given in the instructions
        assert_eq!(pairs[0], (0, 19));
        assert_eq!(pairs[1], (0, 7));
        assert_eq!(pairs[2], (2, 13));
        assert_eq!(pairs[3], (7, 19));
    }

    #[test]
    #[ignore]
    fn test_part1() {
        assert_eq!(5, 6);
    }

    #[test]
    #[ignore]
    fn test_part2() {
        assert_eq!(22, 10);
    }
}
