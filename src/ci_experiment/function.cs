using System;
using ci_library;

namespace ci_experiment
{
    public class Function
    {
		public static void Speak()
		{
			Console.WriteLine(" - boring Should ACTUALLY NOW !!! only show on MYGET xx feed");
			LibraryFunction.SpeakLibrary();
		}
		public static void SomethingElse()
		{
			Console.WriteLine("This does something else #6 I guess");
		}
    }
}
