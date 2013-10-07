/**
 * 5.3 Tuples
 * http://static.rust-lang.org/doc/0.7/tutorial.html#tuples
 *
 * @license MIT license <http://www.opensource.org/licenses/mit-license.php>
 */
fn main() {
	// A Tuple is an immutable fixed-size collection of values. 

	let tuple0 = ();
	println(fmt!("%?", tuple0));

	let mytup: (int, int, float) = (10, 20, 30.0);
	match mytup {
		(a, b, c) => info!(a + b + (c as int))
	}

	let tuple1 = (5i, 6i);
	let (first, _) = tuple1;
	println(first.to_str());
}
