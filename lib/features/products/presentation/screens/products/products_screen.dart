part of 'products.imports.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController  controller=ScrollController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsBloc>()..add(LoadProductsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body:BlocListener<ProductsBloc, ProductsState>(
            listener: (context,state){
              if(state is ProductsLoadedState){
                try {
                  controller.animateTo(0, duration: Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                }catch (ex){}
              }
             },
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (contextBloc, state) {
              if (state is ProductsLoadedState) {
                return Column(
                  children: [
                    // Sorting and Filtering Dropdowns
                    SortAndFilterWidget( ),
                    Expanded(
                      child: ListView.separated(
                        controller:controller ,
                        itemCount:  state.products.length ,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            thickness: 1,
                            indent: 70.0,
                            endIndent: 20.0,
                          );
                        },
                        itemBuilder: ((BuildContext context, int index) {
                          Product product = state.products[index];
                          return ProductTile(
                            product: product,
                            onTap: () {},
                          );
                        }),
                      ),
                    ),
                    buildButtonNavigate(contextBloc,state),
                  ],
                );
              } else if (state is ProductsErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildButtonNavigate(BuildContext context, ProductsLoadedState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<ProductsBloc>(context).add(const PaginationProductsEvent(paginateType:  PaginateType.increase));


          },
          child: Text('Previous'),
        ),
        SizedBox(width: 10.0),
        Text('Page ${state.currentPage}'),
        SizedBox(width: 10.0),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<ProductsBloc>(context).add(const PaginationProductsEvent(paginateType: PaginateType.decrease));


          },
          child: Text('Next'),
        ),
      ],
    );
  }
}


