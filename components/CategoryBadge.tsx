import Link from "next/link";
import type { Category } from "@/lib/supabase/types";

export function CategoryBadge({ category }: { category: Category }) {
  return (
    <Link
      href={`/categoria/${category.slug}`}
      className="inline-flex items-center gap-1.5 rounded-full px-3 py-1 text-xs font-medium text-white transition-opacity hover:opacity-90"
      style={{ backgroundColor: category.cor }}
    >
      {category.nome}
    </Link>
  );
}
